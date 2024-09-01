// Central config file

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
pragma Singleton

Singleton {
    id: root

    // username
    property string name: "TopsyKrets"
    // user terminal (kitty), user shell (fish)
    property string terminal: Quickshell.env("TERM") ?? "konsole"
    property string shell: Quickshell.env("SHELL") ?? "bash"
    // for animations
    property int frameRate: 60
    // default font
    property string font: "JetBrainsMono NerdFont"
    // universal sizes
    property QtObject sizes
    property QtObject colors

    Component.onCompleted: () => {
        console.log("Hello, " + root.name + "!");
    }

    // Pipewire binding
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    sizes: QtObject {
        property int barHeight: 28
        property int barMargin: 6
    }

    colors: QtObject {
        property string bar: "transparent"
        property string mainBG: "#80000000"
        property string mainFG: "#95d3af"
        property string secondaryBG: "#f9f9fa"
        property string secondaryFG: "#404b7c"
        property string modularBG: "404b7c"
        property string modularFG: "95d3af"
        property string modularFG2: "f9f9fa"
        property string border: "#0f9bff"
        property string color1: "#ff8c00"
        property string color2: "#0f9bff" // rgba(15,155,255,1) -- light blue
        property string color3: "#9bff0f" //rgba(155, 255, 15, 1) //-- limegreen
        property string color4: "#FF0000" // -- red
        property string color5: "#0000FF" // -- dark blue
    }

}
