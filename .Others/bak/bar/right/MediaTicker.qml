import "../../"
import "../../functions"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris

Rectangle {
    // Rectangle {
    //     Layout.alignment: Qt.AlignHCenter && Qt.AlignVCenter
    //     width: 20
    //     height: 20
    //     Image {
    //         id: playerIcon
    //         source: playerIconGet
    //         anchors.centerIn: parent
    //         anchors.fill: parent
    //         visible: true
    //     }
    // }
    // Text {
    //     id: artist
    //     text: Mpris.artist
    //     font.bold: true
    //     font.pixelSize: 12
    //     font.family: Cfg.font
    //     color: Cfg.colors.color5
    // }

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
        // artist.color = Cfg.colors.color1;
        // artist.color = Cfg.colors.color5;

        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            mediaPopup.item.mediaTargetVisible = !mediaPopup.item.mediaTargetVisible;
        }
        onEntered: {
            title.color = Cfg.colors.color5;
        }
        onExited: {
            title.color = Cfg.colors.color1;
        }
    }

    Text {
        id: title

        text: MprisPlaybackState === "Playing" ? (Mpris.mediaTitle + " <<>> " + MprisPlayer.artist) : "No Media"
        font.pixelSize: 12
        font.family: Cfg.font
        color: Cfg.colors.color1
        font.bold: true
        anchors.centerIn: parent
        anchors.fill: parent
        visible: true
    }

}
