/* @flow */

import styles from '../css/components/Actions.scss';
import React from 'react';

type Props = {
    onAction: Function,
};

const Actions = (props: Props)  =>
<div className={styles.Actions}>
    <span
        tabIndex="0"
        className={styles.ActionsInfo}
        title="詳しい情報"
        onClick={props.onAction.bind(null,'info')}>&#8505;</span>
    <span
        tabIndex="0"
        className={styles.ActionsEdit}
        title="編集"
        onClick={props.onAction.bind(null,'edit')}>&#10000;</span>
    <span
        tabIndex="0"
        className={styles.ActionsEdit}
        title="削除"
        onClick={props.onAction.bind(null,'delete')}>x</span>
</div>

Actions.defaultProps = {
    onAction: () => {},
};

export default Actions
