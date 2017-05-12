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
                <BeerList items={this.state.beers}/>
            </div>
        );
    }
}

export class InputArea extends Component {
    constructor(props) {
        super(props);
        this.state = {
            text: ''
        };
        this.setText = this.setText.bind(this);
        this.handleClick = this.handleClick.bind(this);
    }

    setText(event) {
        this.setState({text: event.target.value});
    }

    handleClick() {
        this.props.onSubmit(this.state.text);
    }

    render() {
        return (
            <div>
                <input value={this.state.text} onChange={this.setText}/>
                <button onClick={this.handleClick}>Add</button>
            </div>
        )

    }
}

InputArea.PropTypes = {
    onSubmit: React.PropTypes.func.isRequired
};

export class BeerList extends Component {
    render() {
        return this.props.items ?
            (<ul>
                {this.props.items.map((item,index) => (
                    <li key={index}>{item}</li>
                ))}
            </ul>)
            : null;
    }
}
BeerList.propTypes = {
    items: React.PropTypes.array.isRequired
};

ReactDOM.render(
    <BeerListContainer/>,
    document.body.appendChild(document.createElement('div')),
);