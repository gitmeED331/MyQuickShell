import "../../"
import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 10

    Rectangle {
        width: 200
        height: panel.exclusiveZone - 5
        border.color: "black"
        border.width: 1.5
        radius: 10
        color: Cfg.colors.mainBG

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.color = "grey";
            }
            onExited: {
                parent.color = "purple";
            }
        }

    }

    Rectangle {
        //Layout.preferredWidth: sysInfo.width + 30
        height: panel.exclusiveZone - 5
        border.color: "black"
        border.width: 1.5
        radius: 10
        color: Cfg.colors.mainBG

        MouseArea {
            // onEntered: {
            //     parent.color = "grey";
            // }
            // onExited: {
            //     parent.color = "purple";
            // }

            anchors.fill: parent
            hoverEnabled: true
        }

        RowLayout {
            id: apptitle

            spacing: 10
            anchors.centerIn: parent

            Text {
                text: ""
                font.pixelSize: 20
                font.family: Cfg.font
                color: "white"
            }

            Text {
                text: "1.3G"
                font.pixelSize: 20
                font.family: Cfg.font
                color: "white"
            }

        }

    }

}
