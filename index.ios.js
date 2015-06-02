'use strict';

var React = require('react-native');

var Settings = require('./settings.ios');
var Explore = require('./explore.ios');
var LocalKeys = require('./local.ios');

var {
    AppRegistry,
    TabBarIOS,
    StyleSheet,
    Text,
    View,
    Component
    } = React;


class Keys extends Component {
    constructor(properties) {
        super(properties);

        this.state = {
            currentTab: 'local'
        };
    }

    render() {
        return (
            <TabBarIOS>
                <TabBarIOS.Item title='Local Keys'
                                selected={this.state.currentTab === 'local'}
                                onPress={() => {
                this.setState({currentTab : 'local'});
                }}>
                    <LocalKeys/>
                </TabBarIOS.Item>
                <TabBarIOS.Item title='Explore'
                                selected={this.state.currentTab === 'explore'}
                                onPress={() => {
                this.setState({currentTab : 'explore'});
                }}>
                    <Explore/>
                </TabBarIOS.Item>
                <TabBarIOS.Item title='Settings'
                                selected={this.state.currentTab === 'settings'}
                                onPress={() => {
                this.setState({currentTab : 'settings'});
                }}>
                    <Settings/>
                </TabBarIOS.Item>
            </TabBarIOS>)
    }
}


var styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
    },
    instructions: {
        textAlign: 'center',
        color: '#333333',
        marginBottom: 5,
    },
});

AppRegistry.registerComponent('Keys', () => Keys);
