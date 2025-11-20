using Toybox.WatchUi;

class InitialDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {
        // Call the shoppinglist for the first time.
        var config = new Config();
        WatchUi.pushView(new TextView(config.loading), new WatchUi.BehaviorDelegate(), WatchUi.SLIDE_IMMEDIATE);
        var callShoppinglist = new CallShoppingList();
        callShoppinglist.makeRequest();
        return true;
    }
}