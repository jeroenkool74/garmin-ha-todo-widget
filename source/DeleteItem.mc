import Toybox.System;
import Toybox.Communications;
import Toybox.Lang;
import Toybox.WatchUi;

class DeleteItem {
    // set up the response callback function
    function onReceive(responseCode as Number, data as Dictionary?) as Void {

        if (responseCode == 200) {
            // Get the new shopping list when deletion went successfull
            var callShoppinglist = new CallShoppingList();
            callShoppinglist.makeRequest();
        } else {
            // Show 'Error' when somthing went wrong on deletion.
            WatchUi.pushView(new TextView("Error"), new WatchUi.BehaviorDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }

    }

    function makeRequest(item) as Void {
        // Define the call and callback function
        // See HA and Monkey C documentation for more detailed explanation.

        var config = new Config();

        var url = config.baseUrl + "/api/services/todo/remove_item";
        
        var params = {
            "entity_id" => config.entityId,
            "item" => item["uid"],
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
