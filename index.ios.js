'use strict';

var React = require('react-native');
var {
    AppRegistry,
    TabBarIOS,
    StyleSheet,
    Text,
    View,
    Component
    } = React;

class Keys extends Component {
    render() {
        return (
            <TabBarIOS>
                <TabBarIOS.Item title="Local Keys" selected={true}>
                    <View style={styles.container}>
                        <Text style={styles.welcome}>
                            Welcome to React Native!
                        </Text>
                        <Text style={styles.instructions}>
                            To get started, edit index.ios.js
                        </Text>
                        <Text style={styles.instructions}>
                            Press Cmd+R to reload,{'\n'}
                            Cmd+D or shake for dev menu
                        </Text>
                    </View>
                </TabBarIOS.Item>
                <TabBarIOS.Item title="Explore" selected={false}>
                    <View style={styles.container}>
                        <Text style={styles.instructions}>
                            Press Cmd+R to reload,{'\n'}
                            Cmd+D or shake for dev menu
                        </Text>
                    </View>
                </TabBarIOS.Item>
                <TabBarIOS.Item title="Settings" selected={false}>
                    <View style={styles.container}>
                        <Text style={styles.instructions}>
                            Press Cmd+R to reload,{'\n'}
                            Cmd+D or shake for dev menu
                        </Text>
                    </View>
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
