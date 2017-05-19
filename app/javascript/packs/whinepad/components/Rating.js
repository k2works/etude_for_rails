/* @flow */

import styles from '../css/components/Rating.scss';
import React, {Component} from 'react';

type Props = {
    defaultValue: number,
    readonly: boolean,
    max: number,
};

type State = {
    rating: number,
    tmpRating: number,
};

class Rating extends Component {

    props: Props;
    state: State;

    static defaultProps = {
        defaultValue: 0,
        max: 5,
        readonly: false,
    };

    constructor(props: Props) {
        super(props);
        this.state = {
            rating: props.defaultValue,
            tmpRating: props.defaultValue,
        };
    }

    getValue() { // すべての入力ウィジェットで提供されます
        return this.state.rating
    }

    setTemp(rating: number) {  // マウスオーバー時に発生します
        this.setState({tmpRating: rating});
    }

    setRating(rating: number) {  // クリック時に発生します
        this.setState({
            tmpRating: rating,
            rating: rating,
        });
    }

    reset() { // マウスアウト時に、実際の値に表示を戻します
        this.setTemp(this.state.rating);
    }

    componentWillReceiveProps(nextProps: Props) {  // 外部からの変更に応答します
        this.setRating(nextProps.defaultValue);
    }

    render() {
        const stars = [];
        for(let i = 1; i <= this.props.max; i++) {
            stars.push(
                <span
                    className={i <= this.state.tmpRating ? styles.RatingOn : null }
                    key={i}
                    onClick={!this.props.readonly && this.setRating.bind(this, i)}
                    onMouseOver={!this.props.readonly && this.setTemp.bind(this, i)}
                >
                &#9734;
                </span>);
        }
        return (
            <div
                className={this.props.readonly ? styles.RatingReadonly : styles.Rating}
                onMouseOut={this.reset.bind(this)}
            >
                {stars}
                {this.props.readonly || !this.props.id
                    ? null
                    : <input
                        type="hidden"
                        id={this.props.id}
                        value={this.state.rating}/>
                }
            </div>
        );
    }
}

export default Rating