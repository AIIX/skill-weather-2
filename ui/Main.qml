import QtQuick.Layouts 1.4
import QtQuick 2.4
import QtQuick.Controls 2.0
import org.kde.kirigami 2.4 as Kirigami

import Mycroft 1.0 as Mycroft

Mycroft.PaginatedDelegate {
    id: root
    property var current
    property var min
    property var max
    property var condition
    property var weathercode
    property var forecastDump
    graceTime: 300000
    backgroundDim: 0.8
    backgroundImage: getWeatherImagery(weathercode)[1]
    switchHeight: Kirigami.Units.gridUnit * 50

    function getWeatherImagery(weathercode){
        switch(weathercode) {
        case 0:
            return ["Cloudrain.qml", "https://source.unsplash.com/1920x1080/?+sky"]
            break
        case 1:
            return ["Cloudrain.qml", "https://source.unsplash.com/1920x1080/?+scatteredclouds"]
            break
        case 2:
            return ["Cloudrain.qml", "https://source.unsplash.com/1920x1080/?+cloudy"]
            break
        case 3:
            return ["Cloudrain.qml", "https://source.unsplash.com/1920x1080/?+rain"]
            break
        case 4:
            return ["Cloudrain.qml", "https://source.unsplash.com/1920x1080/?+rains"]
            break
        case 5:
            return ["Cloudrain.qml", "https://source.unsplash.com/1920x1080/?+storm"]
            break
        case 6:
            return ["Cloudrain.qml", "https://source.unsplash.com/1920x1080/?+snow"]
            break
        case 7:
            return ["Cloudrain.qml", "https://source.unsplash.com/1920x1080/?+mist"]
            break
        }
    }

    function getForecastImagery(weathercode){
        switch(weathercode) {
        case 0:
            return "icons/day.svg"
            break
        case 1:
            return "icons/cloudy-day-2.svg"
            break
        case 2:
            return "icons/cloudy.svg"
            break
        case 3:
            return "icons/rain.svg"
            break
        case 4:
            return "icons/rain.svg"
            break
        case 5:
            return "icons/storm.svg"
            break
        case 6:
            return "icons/snowy-6.svg"
            break
        case 7:
            return "icons/haze.svg"
            break
        }
    }

    //Page 1
    Kirigami.Page {
        ColumnLayout {
            id: dc
            anchors.centerIn: parent
            spacing: Kirigami.Units.largeSpacing * 2
            Loader {
                id: img
                //fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: Kirigami.Units.gridUnit * 10
                Layout.preferredHeight: Kirigami.Units.gridUnit * 10
                source: getWeatherImagery(weathercode)[0]
            }
            Kirigami.Heading {
                id: titleCurrent
                Layout.leftMargin: Kirigami.Units.smallSpacing
                level: 1
                wrapMode: Text.WordWrap
                font.bold: true
                font.pointSize: Kirigami.Units.gridUnit * 5
                font.weight: Font.ExtraBold
                text: current + "°"
            }
        }
    }

    //Page 2,3,4..etc
    Kirigami.Page {
        ColumnLayout {
            id: d1
            anchors.centerIn: parent
            anchors.margins: Kirigami.Units.largeSpacing
            spacing: Kirigami.Units.largeSpacing

            Kirigami.Heading {
                wrapMode: Text.WordWrap
               // elide: Text.ElideRight
                level: 1
                text: forecastDump.forecast[0].date
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }

            Image {
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: Kirigami.Units.gridUnit * 8
                Layout.preferredHeight: Kirigami.Units.gridUnit * 8
                Layout.alignment: Qt.AlignHCenter
                source: getForecastImagery(forecastDump.forecast[0].weathercode)
            }

            Kirigami.FormLayout {
                Layout.fillWidth: true
                Kirigami.Heading {
                    wrapMode: Text.WordWrap
                    font.bold: true
                    font.pointSize: Kirigami.Units.gridUnit * 4
                    font.weight: Font.ExtraBold
                    elide: Text.ElideRight
                    level: 1
                    text: Math.floor(forecastDump.forecast[0].min) + "°"
                }
                Kirigami.Heading {
                    wrapMode: Text.WordWrap
                    elide: Text.ElideRight
                    level: 1
                    font.bold: true
                    font.pointSize: Kirigami.Units.gridUnit * 4
                    font.weight: Font.ExtraBold
                    text: Math.floor(forecastDump.forecast[0].max) + "°"
                }
            }
        }
    }

    Kirigami.Page {
        ColumnLayout {
            id: d2
            anchors.centerIn: parent
            spacing: Kirigami.Units.largeSpacing
            anchors.margins: Kirigami.Units.largeSpacing

            Kirigami.Heading {
                wrapMode: Text.WordWrap
                //elide: Text.ElideRight
                level: 1
                text: forecastDump.forecast[1].date
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }

            Image {
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: Kirigami.Units.gridUnit * 8
                Layout.preferredHeight: Kirigami.Units.gridUnit * 8
                source: getForecastImagery(forecastDump.forecast[1].weathercode)
                Layout.alignment: Qt.AlignHCenter
            }

            Kirigami.FormLayout {
                Layout.fillWidth: true
                Kirigami.Heading {
                    wrapMode: Text.WordWrap
                    font.bold: true
                    font.pointSize: Kirigami.Units.gridUnit * 4
                    font.weight: Font.ExtraBold
                    elide: Text.ElideRight
                    level: 1
                    text: Math.floor(forecastDump.forecast[1].min) + "°"
                }
                Kirigami.Heading {
                    wrapMode: Text.WordWrap
                    elide: Text.ElideRight
                    level: 1
                    font.bold: true
                    font.pointSize: Kirigami.Units.gridUnit * 4
                    font.weight: Font.ExtraBold
                    text: Math.floor(forecastDump.forecast[1].max) + "°"
                }
            }
        }
    }

    Kirigami.Page {
        ColumnLayout {
            id: d3
            anchors.centerIn: parent
            anchors.margins: Kirigami.Units.largeSpacing
            spacing: Kirigami.Units.largeSpacing

            Kirigami.Heading {
                wrapMode: Text.WordWrap
                //elide: Text.ElideRight
                level: 1
                text: forecastDump.forecast[2].date
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }

            Image {
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: Kirigami.Units.gridUnit * 8
                Layout.preferredHeight: Kirigami.Units.gridUnit * 8
                source: getForecastImagery(forecastDump.forecast[2].weathercode)
                Layout.alignment: Qt.AlignHCenter
            }

            Kirigami.FormLayout {
                Layout.fillWidth: true
                Kirigami.Heading {
                    wrapMode: Text.WordWrap
                    font.bold: true
                    font.pointSize: Kirigami.Units.gridUnit * 4
                    font.weight: Font.ExtraBold
                    elide: Text.ElideRight
                    level: 1
                    text: Math.floor(forecastDump.forecast[2].min) + "°"
                }
                Kirigami.Heading {
                    wrapMode: Text.WordWrap
                    elide: Text.ElideRight
                    level: 1
                    font.bold: true
                    font.pointSize: Kirigami.Units.gridUnit * 4
                    font.weight: Font.ExtraBold
                    text: Math.floor(forecastDump.forecast[2].max) + "°"
                }
            }
        }
    }
}
