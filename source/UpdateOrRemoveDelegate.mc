using Toybox.WatchUi;
using Toybox.System;

class UpdateOrRemoveDelegate extends WatchUi.Menu2InputDelegate {

    hidden var item;

    function initialize(input) {
        item = input;
        Menu2InputDelegate.initialize();
    }

    function onSelect(input) {

        // Pop menu
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

        var config = new Config();

        // Because we popt the menu, we now will replace all the shoppinglist items, this prevents memory overflow.
        WatchUi.switchToView(new TextView(config.loading), new WatchUi.BehaviorDelegate(), WatchUi.SLIDE_IMMEDIATE);

        if (input.getId() == :update) {
            var updateItem = new UpdateItem();
            updateItem.makeRequest(item);
        } else if (input.getId() == :delete) {
            var deleteItem = new DeleteItem();
            deleteItem.makeRequest(item);
        } else { 
            WatchUi.switchToView(new TextView("Error"), new WatchUi.BehaviorDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }
    }
}
