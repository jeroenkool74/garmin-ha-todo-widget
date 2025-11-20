import Toybox.System;
import Toybox.Communications;
import Toybox.Lang;
import Toybox.WatchUi;

class CallShoppingList {

    var config = new Config();

    // set up the response callback function
    function onReceive(responseCode as Number, data as Dictionary?) as Void {

        if (responseCode != 200 or data == null) {
            WatchUi.pushView(new TextView("Error"), new WatchUi.BehaviorDelegate(), WatchUi.SLIDE_IMMEDIATE);
            return;
        }

        var serviceResponse = data["service_response"];
        var todoResponse = serviceResponse != null ? serviceResponse[config.entityId] : null;
        var items = todoResponse != null ? todoResponse["items"] : null;

        if (items == null) {
            WatchUi.pushView(new TextView("Error"), new WatchUi.BehaviorDelegate(), WatchUi.SLIDE_IMMEDIATE);
            return;
        }

        var menu = new WatchUi.Menu2({:title=>config.listTitle});
        var itemLookup = {};
        var shown = 0;
        var maxItems = 100;

        // Add active items first, then completed ones, while keeping ids tied to Home Assistant.
        for (var i = 0; i < items.size() and shown < maxItems; i++) {
            var item = items[i];
            if (item == null or item["summary"] == null or item["uid"] == null) {
                continue;
            }
            var status = item["status"];
            if (status == null or (status.equals("completed") == false)) {
                var id = item["uid"];
                menu.addItem(new MenuItem(item["summary"], null, id, {}));
                itemLookup.put(id, item);
                shown++;
            }
        }

        for (var i = 0; i < items.size() and shown < maxItems; i++) {
            var item = items[i];
            if (item == null or item["summary"] == null or item["uid"] == null) {
                continue;
            }
            var status = item["status"];
            if (status != null and status.equals("completed")) {
                var id = item["uid"];
                menu.addItem(new MenuItem("X " + item["summary"], null, id, {}));
                itemLookup.put(id, item);
                shown++;
            }
        }

        // Pass the dictionary with the delegate, to obtain the item when selecting a menu item.
        var delegate = new SelectItemDelegate(itemLookup);

        // Print the menu on the screen. Switch is used minimize memory usage.
        WatchUi.switchToView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);

    }

    function makeRequest() as Void {
        // Define the call and callback function
        // See HA and Monkey C documentation for more detailed explanation.

        var url = config.baseUrl + "/api/services/todo/get_items?return_response=null";

        var params = {
            "entity_id" => config.entityId
        };

        var options = {
            :method => Communications.HTTP_REQUEST_METHOD_POST,
            :headers => {
            "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON,
            "Authorization" => "Bearer " + config.longLivedAccessToken
            },
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };

        Communications.makeWebRequest(url, params, options, method(:onReceive));
    }
}
