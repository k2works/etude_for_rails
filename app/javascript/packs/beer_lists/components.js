import React, {Component} from 'react'
import ReactDOM from 'react-dom'

export class BeerListContainer extends Component {
    constructor(props) {
        super(props);
        this.state = {
            beers: []
        };
        this.addItem = this.addItem.bind(this);
    }
    addItem(name) {
        this.setState({
            beers: [].concat(this.state.beers).concat([name])
        });
    }
    render() {
        return(
            <div>
                <InputArea onSubmit={this.addItem}/>
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

InputArea.PropTypes = {
    onSubmit: React.PropTypes.func.isRequired
};

export class BeerList extends Component {
    render() {
        return <ul/>
    }
}

ReactDOM.render(
    <BeerListContainer/>,
    document.body.appendChild(document.createElement('div')),
);