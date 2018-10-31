import QtQuick.Layouts 1.4
import QtQuick 2.4
import QtQuick.Controls 2.0
import org.kde.kirigami 2.4 as Kirigami
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: cloudRain
    anchors.fill: parent

    function rand(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    PlasmaCore.Svg {
        id: rainSvg
        multipleImages: true
        imagePath: Qt.resolvedUrl("icons/Weather_rain.svg")
    }

    Item {
        id: cloudIcon
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.verticalCenter
            margins: Math.round(parent.width * 0.2)
        }

        Rectangle { // Cloud_base
            id: cloudBase
            anchors.centerIn: parent
            color: "#bbbdbf"
            radius: height
            width: Kirigami.Units.gridUnit * 11
            height: Math.round(width / (295/132))
        }

        Rectangle { // Cloud_bit_1
            id: cloudBit1
            x: Math.round(cloudBase.x + cloudBase.width * 0.4 - width / 2)
            y: Math.round(cloudBase.y - height * 0.6)
            radius: width
            width: Math.round(cloudBase.width * (150/295))
            height: width
            color: cloudBase.color

            transform: Translate {
                id: cloudBit1Translate
            }

            SequentialAnimation {
                loops: Animation.Infinite
                running: cloudBit1.width > 0

                NumberAnimation {
                    target: cloudBit1Translate
                    property: "x"
                    from: 0
                    to: -cloudBit1.width / 10
                    duration: 2000
                    easing: Easing.InOutQuad
                }
                NumberAnimation {
                    target: cloudBit1Translate
                    property: "x"
                    to: 0
                    duration: 2000
                    easing: Easing.InOutQuad
                }
            }
        }

        Rectangle { // Cloud_bit_2
            id: cloudBit2
            x: Math.round(cloudBase.x + cloudBase.width * 0.7 - width / 2)
            y: Math.round(cloudBase.y - height * 0.6)
            radius: width
            width: Math.round(cloudBase.width * (103.6/295))
            height: width
            color: cloudBase.color

            // Can we just reverse the animation when it ends and restart?
            SequentialAnimation {
                loops: Animation.Infinite
                running: true

                NumberAnimation {
                    target: cloudBit2
                    property: "scale"
                    from: 1
                    to: 1.5
                    duration: 2000
                    easing: Easing.InOutQuad
                }
                NumberAnimation {
                    target: cloudBit2
                    property: "scale"
                    from: 1.5
                    to: 1
                    duration: 2000
                    easing: Easing.InOutQuad
                }
            }
        }

        Repeater {
            /*Tesla*/ model: 3

            PlasmaCore.SvgItem {
                id: droplet

                svg: rainSvg
                elementId: "rain_drop"
                width: Math.round(cloudBase.width * (57.319/295))
                height: Math.round(width / (57.319/77.123))

                x: Math.round(cloudBase.x + cloudBase.width * (30/295) + (index * cloudBase.width * (80/295)))
                y: Math.round(cloudBase.y + cloudBase.height * 1.05)
                scale: 0

                transform: Translate {
                    id: dropletTranslate
                }

                SequentialAnimation {
                    running: droplet.width > 0

                    PauseAnimation {
                        duration: index * 200
                    }

                    ParallelAnimation {
                        id: fallAnimation
                        readonly property int totalDuration: 800
                        loops: Animation.Infinite

                        SequentialAnimation {
                            PropertyAction { // reset positions before animation restarts
                                target: dropletTranslate
                                properties: "x,y"
                                value: 0
                            }

                            NumberAnimation {
                                target: droplet
                                property: "scale"
                                from: 0
                                to: 1
                                duration: 200
                            }

                            ParallelAnimation {
                                NumberAnimation {
                                    target: dropletTranslate
                                    property: "x"
                                    from: 0
                                    to: -droplet.height
                                    duration: fallAnimation.totalDuration
                                }
                                NumberAnimation {
                                    target: dropletTranslate
                                    property: "y"
                                    from: 0
                                    to: droplet.height
                                    duration: fallAnimation.totalDuration
                                }

                                SequentialAnimation {
                                    PauseAnimation {
                                        duration:  fallAnimation.totalDuration - 200
                                    }

                                    NumberAnimation {
                                        target: droplet
                                        property: "scale"
                                        from: 1
                                        to: 0
                                        duration: 200
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
