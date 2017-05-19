/* @flow */

import styles from '../css/components/Dialog.scss';
import Button from './Button';
import React, {Component} from 'react';

type Props = {
    header: string,
    confirmLabel: string,
    modal: boolean,
    onAction: Function,
    hasCancel: ?boolean,
    children?: Array<any>,
};


class Dialog extends Component {

    props: Props;

    static defaultProps = {
        confirmLabel: 'ok',
        modal: false,
        onAction: (_) => {},
        hasCancel: true,
    };

    componentWillUnmount() {
        document.body.classList.remove(styles.DialogModalOpen);
    }
    componentDidMount() {
        if (this.props.modal) {
            document.body.classList.add(styles.DialogModalOpen);
        }
    }
    render() {
        return (
            <div className={this.props.modal ? styles.DialogModal : styles.Dialog}>
                <div className={this.props.modal ? styles.DialogModalWrap : null}>
                    <div className={styles.DialogHeader}>{this.props.header}</div>
                    <div className={styles.DialogBody}>{this.props.children}</div>
                    <div className={styles.DialogFooter}>
                        {this.props.hasCancel
                            ? <span
                                className={styles.DialogDismiss}
                                onClick={this.props.onAction.bind(this, 'dismiss')}>
                                キャンセル
                            </span>
                            : null
                        }
                        <Button onClick={this.props.onAction.bind(this,
                            this.props.hasCancel ? 'confirm' : 'dismiss')}>
                            {this.props.confirmLabel}
                        </Button>
                    </div>
                </div>
            </div>
        );
    }
}

export default Dialog