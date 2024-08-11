import "../../"
import "../../functions"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris

Rectangle {
    id: root

    property int spacing: 20

    height: parent.height - 5
    width: 350
    radius: 30
    border.color: Cfg.colors.border
    border.width: 1.5
    clip: true
    color: Cfg.colors.mainBG

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            mediaPopup.item.targetVisible = !mediaPopup.item.targetVisible;
        }
        onEntered: {
            title.color = Cfg.colors.color5;
            artist.color = Cfg.colors.color1;
        }
        onExited: {
            title.color = Cfg.colors.color1;
            artist.color = Cfg.colors.color5;
        }
    }

    RowLayout {
        x: (root.width / 2) - (width / 2)
        anchors.verticalCenter: parent.verticalCenter

        Text {
            id: title

            text: Mpris.mediaTitle
            font.pixelSize: 12
            font.family: Cfg.font
            color: Cfg.colors.color1
            font.bold: true
        }

        Rectangle {
            anchors.centerIn: parent
            width: parent.height - 10
            height: parent.height - 10

            Image {
                id: playerIcon

                source: Quickshell.iconPath(Mpris.desktopEntry)
                anchors.centerIn: parent
                width: parent.height
                height: parent.height
                visible: true
            }

        }

        Text {
            id: artist

            text: Mpris.artist
            font.bold: true
            font.pixelSize: 12
            font.family: Cfg.font
            color: Cfg.colors.color5
        }

    }

}
