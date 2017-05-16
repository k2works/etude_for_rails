import React from 'react';
import ReactDOM from 'react-dom';

var Excel = React.createClass({
    displayName: 'Excel',

    propTypes: {
        headers: React.PropTypes.arrayOf(
            React.PropTypes.string
        ),
        initialData: React.PropTypes.arrayOf(
            React.PropTypes.arrayOf(
                React.PropTypes.string
            )
        ),
    },

    getInitialState() {
        return {data: this.props.initialData};
    },

    render: function() {
        return (
            React.DOM.table(null,
                React.DOM.thead(null,
                    React.DOM.tr(null,
                        this.props.headers.map(function(title, idx) {
                            return React.DOM.th({key: idx}, title);
                        })
                    )
                ),
                React.DOM.tbody(null,
                    this.state.data.map(function(row, idx) {
                        return (
                            React.DOM.tr({key: idx},
                                row.map(function(cell, idx) {
                                    return React.DOM.td({key: idx}, cell);
                                })
                            )
                        );
                    })
                )
            )
        );
    }
});

var headers = [
    "タイトル", "著者", "言語", "出版年", "売上部数"
];

var data = [
    ["The Lord of the Rings", "J. R. R. Tolkien", "English", "1954–1955", "150 million"],
    ["Le Petit Prince (The Little Prince)", "Antoine de Saint-Exupéry", "French", "1943", "140 million"],
    ["Harry Potter and the Philosopher's Stone", "J. K. Rowling", "English", "1997", "107 million"],
    ["And Then There Were None", "Agatha Christie", "English", "1939", "100 million"],
    ["Dream of the Red Chamber", "Cao Xueqin", "Chinese", "1754–1791", "100 million"],
    ["The Hobbit", "J. R. R. Tolkien", "English", "1937", "100 million"],
    ["She: A History of Adventure", "H. Rider Haggard", "English", "1887", "100 million"],
];

ReactDOM.render(
    React.createElement(Excel, {
        headers: headers,
        initialData: data,
    }),
    document.getElementById("app")
);
