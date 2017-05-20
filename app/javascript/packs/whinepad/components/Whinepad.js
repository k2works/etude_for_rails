/* @flow */

import styles from '../css/components/Whinepad.scss'
import Button from './Button';
import CRUDActions from '../flux/CRUDActions';
import CRUDStore from '../flux/CRUDStore';
import Dialog from './Dialog';
import Excel from './Excel';
import Form from './Form';
import React, {Component} from 'react';

type State = {
    addnew: boolean,
    count: number,
};

class Whinepad extends Component {

    state: State;

    constructor() {
        super();
        this.state = {
            addnew: false,
            count: CRUDStore.getCount(),
        };

        CRUDStore.addListener('change', () => {
            this.setState({
                count: CRUDStore.getCount(),
            })
        });
    }

    shouldComponentUpdate(newProps: Object, newState: State): boolean {
        return newState.addnew !== this.state.addnew || newState.count !== this.state.count;
    }

    _addNewDialog() {
        this.setState({addnew: true});
    }

    _addNew(action: string) {
        this.setState({addnew: false});
        if (action === 'confirm') {
            CRUDActions.create(this.refs.form.getData());
        }
    }

    render() {
        return (
            <div className={styles.Whinepad}>
                <div className={styles.WhinepadToolbar}>
                    <div className={styles.WhinepadToolbarAdd}>
                        <Button
                            onClick={this._addNewDialog.bind(this)}
                            className={styles.WhinepadToolbarAddButton}>
                            + 追加
                        </Button>
                    </div>
                    <div className={styles.WhinepadToolbarSearch}>
                        <input
                            placeholder={this.state.count === 1
                                ? '１件から検索...'
                                : `検索 ${this.state.count} 件..`
                            }
                            onChange={CRUDActions.search.bind(CRUDActions)}
                            onFocus={CRUDActions.startSearching.bind(CRUDActions)} />
                    </div>
                </div>
                <div className={styles.WhinepadDatagrid}>
                    <Excel />
                </div>
                {this.state.addnew
                    ? <Dialog
                        modal={true}
                        header="項目の追加"
                        confirmLabel="追加"
                        onAction={this._addNew.bind(this)}
                    >
                        <Form ref="form" />
                    </Dialog>
                    : null}
            </div>
        );
    }
}

export default Whinepad;