const { GLib } = imports.gi;
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
const { Box, Button, Icon, Label, Scrollable, Slider, Stack } = Widget;
const { execAsync, exec } = Utils;
import { MaterialIcon } from '../../.commonwidgets/materialicon.js';
import { setupCursorHover } from '../../.widgetutils/cursorhover.js';
import { ConfigGap, ConfigSpinButton, ConfigToggle } from '../../.commonwidgets/configwidgets.js';
import { ModuleNightLight } from '../quicktoggles.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';

export const gammaTemperature = Variable(4000) // set gammastep's default color temperature to 4000K  
export const gammaBrightness = Variable(10) // set gammastep's default screen dim to 1.0 

const HyprlandToggle = ({ icon, name, desc = null, option, enableValue = 1, disableValue = 0, extraOnChange = () => { } }) => ConfigToggle({
    icon: icon,
    name: name,
    desc: desc,
    initValue: JSON.parse(exec(`hyprctl getoption -j ${option}`))["int"] != 0,
    onChange: (self, newValue) => {
        execAsync(['hyprctl', 'keyword', option, `${newValue ? enableValue : disableValue}`]).catch(print);
        extraOnChange(self, newValue);
    }
});

const HyprlandSpinButton = ({ icon, name, desc = null, option, ...rest }) => ConfigSpinButton({
    icon: icon,
    name: name,
    desc: desc,
    initValue: Number(JSON.parse(exec(`hyprctl getoption -j ${option}`))["int"]),
    onChange: (self, newValue) => {
        execAsync(['hyprctl', 'keyword', option, `${newValue}`]).catch(print);
    },
    ...rest,
});

const Subcategory = (children) => Box({
    className: 'margin-left-20',
    vertical: true,
    children: children,
})

export default (props) => {
    const ConfigSection = ({ name, children }) => Box({
        vertical: true,
        className: 'spacing-v-5',
        children: [
            Label({
                hpack: 'center',
                className: 'txt txt-large margin-left-10',
                label: name,
            }),
            Box({
                className: 'margin-left-10 margin-right-10',
                vertical: true,
                children: children,
            })
        ]
    })
    const mainContent = Scrollable({
        vexpand: true,
        child: Box({
            vertical: true,
            className: 'spacing-v-10',
            children: [
                ConfigSection({
                    name: 'Effects', children: [
                        ConfigSpinButton({
                            icon: 'sunny_snowing',
                            name: 'Gammastep Temperature',
                            desc: 'In Kelvin, the Color Temperature of the display.',
                            initValue: gammaTemperature.value,
                            step: 500, minValue: 1000, maxValue: 25000,
                            onChange: (self, newValue) => {
                                gammaTemperature.value = newValue;
                            },
                        }),
                        ConfigSpinButton({
                            icon: 'sunny_snowing',
                            name: 'Gammastep Brightness',
                            desc: 'The screen dim, controlled be gammastep.',
                            initValue: gammaBrightness.value,
                            step: 1, minValue: 1, maxValue: 10,
                            onChange: (self, newValue) => {
                                gammaBrightness.value = newValue;
                            },
                        }),
                        ConfigGap({}),
                        HyprlandToggle({
                            icon: 'animation', name: 'Animations', desc: '[Hyprland] [GTK]\nEnable animations', option: 'animations:enabled',
                            extraOnChange: (self, newValue) => execAsync(['gsettings', 'set', 'org.gnome.desktop.interface', 'enable-animations', `${newValue}`])
                        }),
                        Subcategory([
                            ConfigSpinButton({
                                icon: 'clear_all',
                                name: 'Choreography delay',
                                desc: 'In milliseconds, the delay between animations of a series',
                                initValue: userOptions.animations.choreographyDelay,
                                step: 10, minValue: 0, maxValue: 1000,
                                onChange: (self, newValue) => {
                                    userOptions.animations.choreographyDelay = newValue;
                                },
                            })
                        ]),
                    ]
                }),
                ConfigSection({
                    name: 'Developer', children: [
                        HyprlandToggle({ icon: 'speed', name: 'Show FPS', desc: "[Hyprland]\nShow FPS overlay on top-left corner", option: "debug:overlay" }),
                        HyprlandToggle({ icon: 'sort', name: 'Log to stdout', desc: "[Hyprland]\nPrint LOG, ERR, WARN, etc. messages to the console", option: "debug:enable_stdout_logs" }),
                        HyprlandToggle({ icon: 'motion_sensor_active', name: 'Damage tracking', desc: "[Hyprland]\nEnable damage tracking\nGenerally, leave it on.\nTurn off only when a shader doesn't work", option: "debug:damage_tracking", enableValue: 2 }),
                        HyprlandToggle({ icon: 'destruction', name: 'Damage blink', desc: "[Hyprland] [Epilepsy warning!]\nShow screen damage flashes", option: "debug:damage_blink" }),
                    ]
                }),
            ]
        })
    });
    const footNote = Box({
        homogeneous: true,
        children: [Label({
            hpack: 'center',
            className: 'txt txt-italic txt-subtext margin-5',
            label: 'Not all changes are saved',
        })]
    })
    return Box({
        ...props,
        className: 'spacing-v-5',
        vertical: true,
        children: [
            mainContent,
            footNote,
        ]
    });
}