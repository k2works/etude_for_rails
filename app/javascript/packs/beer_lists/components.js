import React, {Component} from 'react'
import ReactDOM from 'react-dom'

export class BeerListContainer extends Component {
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