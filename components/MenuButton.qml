import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Controls.impl

TabButton {
    id: control

    // property alias title: control.text
    // property alias iconSrc: control.icon.source

    icon.source: "qrc:/assets/movie.svg"
    icon.color: control.checked ? "white" : "black"


    // Modern flat colors
    property color activeColor: "#6366f1"  // Indigo-500
    property color activeBorder: "#4f46e5" // Indigo-600
    property color inactiveColor: "#f3f4f6" // Gray-100
    property color inactiveBorder: "#d1d5db" // Gray-300
    property color activeText: "white"
    property color inactiveText: "#111827" // Gray-900

    scale: control.hovered ? 1.1 : 1.0

    Behavior on scale {
        NumberAnimation {
            duration: 120; easing.type: Easing.OutQuad
        }

    }

    contentItem: IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display

        icon: control.icon
        text: control.text
        font: control.font
        color: control.checked ? "white" : "black"
    }

    background: Rectangle {
        color: control.checked ? "#3498db" : "white"
        border.color: control.checked ? "#2980b9" : "#bdc3c7"
        border.width: 1
        radius: 8
    }
}
