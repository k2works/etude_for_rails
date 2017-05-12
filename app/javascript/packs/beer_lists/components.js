import React, {Component} from 'react'
import ReactDOM from 'react-dom'

export class BeerListContainer extends Component {
    constructor(props) {
        super(props);
        this.state = {
            beers: []
        };
    }
    addItem(name) {
        this.setState({
            beers: [].concat(this.state.beers).concat([name])
        });
    }
    render() {
        return(
            <div>
                <InputArea/>
                <BeerList/>
            </div>
        );
    }
}

export class InputArea extends Component {
    render() {
        return <input/>
    }
}

export class BeerList extends Component {
    render() {
        return <ul/>
    }
}

ReactDOM.render(
    <BeerListContainer/>,
    document.body.appendChild(document.createElement('div')),
);