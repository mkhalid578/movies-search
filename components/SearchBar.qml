import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

TextField {
    id: find

    property var fullHistory: ["apple", "banana", "cherry"]
    property var filteredHistory: []
    signal searchEntered()


    font.pixelSize: 30
    placeholderText: qsTr("Find movies...")
    focus: true

    function updateFilteredHistory(input) {
        if (input === "") {
            filteredHistory = fullHistory
        } else {
            filteredHistory = fullHistory.filter(function(item) {
                return item.toLowerCase().indexOf(input.toLowerCase()) !== -1
            })
        }
    }

    Keys.onReturnPressed: {
        searchEntered();
        find.accepted()
    }

    onTextEdited: {
        if (text === "") {
            popup.close()
        } else {

            updateFilteredHistory(text)
            popup.open()
        }
    }

    onAccepted: {
        if (!fullHistory.includes(text) && text !== "") {
            // Remove old duplicate (if any)
            let index = fullHistory.indexOf(text)
            if (index !== -1)
                fullHistory.splice(index, 1)

            // Add new search at the top
            fullHistory.unshift(text)
        }

        updateFilteredHistory("");
        popup.close()

    }


    Popup {
        id: popup

        modal: false
        focus: false
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        visible: false

        // y: find.y + find.height

        width: 360
        height: 400

        background: Rectangle {
            color: "#ffffff"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1
        }

        // Animate y + opacity
        property real baseY: find.y + find.height + 4
        y: baseY + (visible ? 0 : -5)
        opacity: visible ? 1 : 0

        Behavior on y {
            NumberAnimation {
                duration: 180
                easing.type: Easing.OutCubic
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 150
                easing.type: Easing.InOutQuad
            }
        }


        contentItem: ListView {
            id: historyList
            width: popup.width
            height: Math.min(contentHeight, 150)
            model: find.filteredHistory

            delegate: ItemDelegate {
                text: modelData

                width: parent.width
                background: Rectangle {
                    color: hovered ? "#f0f0f0" : "#ffffff"
                }
                onClicked: {
                    find.text = modelData
                    popup.visible = false
                }
            }
        }

    }
}
