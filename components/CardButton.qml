import QtQuick
import QtQuick.Controls.Basic as T

T.Button {

    id: control

    required property string cardIcon

    property bool liked: false

    scale: control.down ? 0.96 : (hovered ? 1.07 : 1.0)

    background: Rectangle {
        anchors.fill: parent
        radius: 8
        color: control.down ? "#bbbbbb"
                            : control.hovered ? "#dddddd"
                                              : "#f0f0f0"
        border.color: "#cccccc"
        border.width: 1
    }

    onClicked: liked = !liked

    icon.source: control.cardIcon
    icon.width: 24
    icon.height: 24
    icon.color: liked ? "#2196f3" : "#999999"

    Behavior on icon.color {
        ColorAnimation {
            duration: 200
        }
    }

    // Behavior on scale {
    //     NumberAnimation {
    //         duration: 150
    //         easing.type: Easing.OutQuad
    //     }
    // }

    SequentialAnimation on scale {
        NumberAnimation { to: 2.0; duration: 180; easing.type: Easing.OutCubic }
        NumberAnimation { to: 1.0; duration: 180; easing.type: Easing.InCubic }
    }
}

