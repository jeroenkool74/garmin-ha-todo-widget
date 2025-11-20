using Toybox.WatchUi;
using Toybox.System;

class SelectItemDelegate extends WatchUi.Menu2InputDelegate {

    hidden var itemById;

    function initialize(input) {
        itemById = input;
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        // First we obtain the item that corresponds with the selected menu entry.
        var item_res = itemById[item.getId()];

        if (item_res == null) {
            WatchUi.switchToView(new TextView("Error"), new WatchUi.BehaviorDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }

        var config = new Config();

        // If the item is already selected, show a menu with to deselect or delete
        if (item_res["status"].equals("completed")){
            var menu = new WatchUi.Menu2({:title=>item_res["summary"]});
            var delegate;
            menu.addItem(new MenuItem(config.deselect, null, :update, {}));
            menu.addItem(new MenuItem(config.delete, null, :delete, {}));
            delegate = new UpdateOrRemoveDelegate(item_res);
            WatchUi.pushView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);
        } else {
            // If the item is not checked, we check the item
            WatchUi.switchToView(new TextView(config.loading), new WatchUi.BehaviorDelegate(), WatchUi.SLIDE_IMMEDIATE);
            var updateItem = new UpdateItem();
            updateItem.makeRequest(item_res);
        }
    }
}
