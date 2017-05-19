import styles from '../css/components/Actions.scss';
import React, {PropTypes} from 'react';

const Actions = props =>
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

Actions.propTypes = {
    onAction: PropTypes.func,
};

Actions.defaultProps = {
    onAction: () => {},
};

export default Actions
