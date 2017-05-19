import styles from '../css/components/Dialog.scss';
import Button from './Button';
import React, {Component, PropTypes} from 'react';

class Dialog extends Component {
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

Dialog.propTypes = {
    header: PropTypes.string.isRequired,
    confirmLabel: PropTypes.string,
    modal: PropTypes.bool,
    onAction: PropTypes.func,
    hasCancel: PropTypes.bool,
};

Dialog.defaultProps = {
    confirmLabel: 'OK',
    modal: false,
    onAction: () => {},
    hasCancel: true,
};

export default Dialog