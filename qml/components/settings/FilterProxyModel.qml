import QtQuick
import QtQml.Models 2.3

DelegateModel {
    property var filterAccepts: function(item) {
        return true
    }

    onFilterAcceptsChanged: {
        refilter()
    }

    function refilter() {
        if (hidden.count > 0) {
            hidden.setGroups(0, hidden.count, "default")
        }
        if (items.count > 0) {
            items.setGroups(0, items.count, "default")
        }
    }

    function filter() {
        while (unsortedItems.count > 0) {
            var item = unsortedItems.get(0)
            if (filterAccepts(item.model)) {
                item.groups = "items"
            }
            else {
                item.groups = "hidden"
            }
        }
    }

    items.includeByDefault: false
    groups: [
        DelegateModelGroup {
            id: unsortedItems
            name: "default"
            includeByDefault: true
            onChanged: filter()
        },
        DelegateModelGroup {
            id: hidden
            name: "hidden"
        }
    ]
}
