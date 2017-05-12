import React, {Component} from 'react'
import ReactDOM from 'react-dom'

export class BeerListContainer extends Component {
    render() {
        return <span>Beer!</span>
    }
}

ReactDOM.render(
    <BeerListContainer/>,
    document.body.appendChild(document.createElement('div')),
);