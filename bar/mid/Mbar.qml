import QtQuick
import QtQuick.Layouts
import "root:"
import "root:functions"

Rectangle {
    id: root

    property int spacing: 20

    height: parent.height - 5
    width: 350
    radius: 10
    border.color: Cfg.colors.border
    border.width: 1.5
    clip: true
    color: Cfg.colors.mainBG

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            mediaPopup.item.mediaTargetVisible = !mediaPopup.item.mediaTargetVisible;
        }
    }

    Text {
        id: title

        x: (root.width / 2) - (width / 2)
        anchors.verticalCenter: parent.verticalCenter
        text: Mpris.mediaTitle
        font.pixelSize: 16
        font.family: Cfg.font
        color: "white"
        onWidthChanged: {
            if (width > parent.width)
                movingText.running = true;
            else
                movingText.running = false;
        }

        NumberAnimation {
            id: movingText

            running: false
            property: "x"
            target: title
            from: 0
            to: -title.width - root.spacing
            duration: title.width * 9
            loops: Animation.Infinite
        }

        Text {
            x: movingText.running ? title.width + root.spacing : root.width
            text: title.text
            font.pixelSize: parent.font.pixelSize
            font.family: parent.font.family
            color: parent.color
        }

    }

}
