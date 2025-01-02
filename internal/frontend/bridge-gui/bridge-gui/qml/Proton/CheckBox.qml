// Copyright (c) 2025 Proton AG
// This file is part of Proton Mail Bridge.
// Proton Mail Bridge is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// Proton Mail Bridge is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// You should have received a copy of the GNU General Public License
// along with Proton Mail Bridge. If not, see <https://www.gnu.org/licenses/>.
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Templates as T

T.CheckBox {
    id: control

    property ColorScheme colorScheme
    property bool error: false

    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding, implicitIndicatorHeight + topPadding + bottomPadding)
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    padding: 0
    spacing: 8

    contentItem: CheckLabel {
        color: {
            if (!enabled) {
                return control.colorScheme.text_disabled;
            }
            if (error) {
                return control.colorScheme.signal_danger;
            }
            return control.colorScheme.text_norm;
        }
        font.family: ProtonStyle.font_family
        font.letterSpacing: ProtonStyle.body_letter_spacing
        font.pixelSize: ProtonStyle.body_font_size
        font.weight: ProtonStyle.fontWeight_400
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        lineHeight: ProtonStyle.body_line_height
        lineHeightMode: Text.FixedHeight
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0
        text: control.text
    }
    indicator: Rectangle {
        border.color: {
            if (!control.enabled) {
                return control.colorScheme.field_disabled;
            }
            if (control.error) {
                return control.colorScheme.signal_danger;
            }
            if (control.hovered || control.activeFocus) {
                return control.colorScheme.interaction_norm_hover;
            }
            return control.colorScheme.field_norm;
        }
        border.width: control.checked ? 0 : 1
        color: {
            if (!checked) {
                return control.colorScheme.background_norm;
            }
            if (!control.enabled) {
                return control.colorScheme.field_disabled;
            }
            if (control.error) {
                return control.colorScheme.signal_danger;
            }
            if (control.hovered || control.activeFocus) {
                return control.colorScheme.interaction_norm_hover;
            }
            return control.colorScheme.interaction_norm;
        }
        implicitHeight: 20
        implicitWidth: 20
        radius: ProtonStyle.checkbox_radius
        x: text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2

        ColorImage {
            color: "#FFFFFF"
            height: parent.height - 4
            source: "/qml/icons/ic-check.svg"
            sourceSize.height: parent.height - 4
            sourceSize.width: parent.width - 4
            visible: control.checkState === Qt.Checked
            width: parent.width - 4
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
        }

        // TODO: do we need PartiallyChecked state?

        // Rectangle {
        //    x: (parent.width - width) / 2
        //    y: (parent.height - height) / 2
        //    width: 16
        //    height: 3
        //    color: control.palette.text
        //    visible: control.checkState === Qt.PartiallyChecked
        //}
    }
}
