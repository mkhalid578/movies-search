import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

TextField {
    id: find

    property var fullHistory: ["apple", "banana", "cherry"]
    property var filteredHistory: []
    signal searchEntered()


    font.pixelSize: 16
    placeholderText: qsTr("Find movies...")

    padding: 32

    function updateFilteredHistory(input) {
        if (input === "") {
            filteredHistory = fullHistory
        } else {
            filteredHistory = fullHistory.filter(function(item) {
                return item.toLowerCase().indexOf(input.toLowerCase()) !== -1
            })
        }
    }

    background: Rectangle {
        // color: "white"
        radius: 12


        color: "white"
        border.width: 1
        border.color: find.focus ? "#0078d7" : "#ccc"

        Behavior on border.color {
            ColorAnimation {
                duration: 150
                easing.type: Easing.InOutQuad
            }
        }

    }

    // Embedded search icon
    Image {
        id: searchIcon
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 8
        width: 24
        height: 24
        source: "qrc:/assets/search.svg" // or use SVG or local path

        x: find.focus ? 8 : -24
        opacity: find.focus ? 0.6 : 0.0

        Behavior on x { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
        Behavior on opacity { NumberAnimation { duration: 150 } }
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

        width: 360
        height: Math.min(historyList.contentHeight + 20, 300)

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
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 180
                easing.type: Easing.InOutQuad
            }
        }


        contentItem: ListView {
            id: historyList
            width: popup.width
            height: Math.min(contentHeight, 150)
            model: find.filteredHistory

            delegate: ItemDelegate {
                id: historyItem
                text: modelData
                icon.source: "qrc:/assets/close.svg"


                width: parent.width
                background: Rectangle {
                    radius: 4
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
