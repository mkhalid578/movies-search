import QtQuick
import QtQuick.Controls.Basic as T

T.Button {

    id: control

    required property string cardIcon

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

    icon.source: control.cardIcon
    icon.width: 24
    icon.height: 24
    icon.color: "black"

    Behavior on scale {
        NumberAnimation {
            duration: 150
            easing.type: Easing.OutQuad
        }
    }
}

