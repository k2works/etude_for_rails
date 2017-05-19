/* @flow */

import styles from '../css/components/Whinepad.scss'
import Button from './Button';
import Dialog from './Dialog';
import Excel from './Excel';
import Form from './Form';
import React, {Component} from 'react';

type Data = Array<Object>;

type Props = {
    schema: Array<Object>,
    initialData: Data,
};

type State = {
    data: Data,
    addnew: boolean,
};

class Whinepad extends Component {
    props: Props;
    state: State;
    _preSearchData: Data;
    constructor(props: Props) {
        super(props);
        this.state = {
            data: props.initialData,
            addnew: false,
        };
    }

    _addNewDialog() {
        this.setState({addnew: true});
    }

    _addNew(action: string) {
        if (action === 'dismiss') {
            this.setState({addnew: false});
            return;
        }
        let data = Array.from(this.state.data);
        data.unshift(this.refs.form.getData());
        this.setState({
            addnew: false,
            data: data,
        });
        this._commitToStorage(data);
    }

    _onExcelDataChange(data: Data) {
        this.setState({data: data});
        this._commitToStorage(data);
    }

    _commitToStorage(data: Data) {
        localStorage.setItem('data', JSON.stringify(data));
    }

    _startSearching() {
        this._preSearchData = this.state.data;
    }

    _doneSearching() {
        this.setState({
            data: this._preSearchData,
        });
    }

    _search(e: Event) {
        const target = ((e.target: any): HTMLInputElement);
        const needle: string = target.value.toLowerCase();
        if(!needle) {
            this.setState({data: this._preSearchData});
            return;
        }
        const fields = this.props.schema.map(item => item.id);
        const searchdata = this._preSearchData.filter(row => {
            for(let f = 0; f < fields.length; f++) {
                if (row[fields[f]].toString().toLowerCase().indexOf(needle) > -1) {
                    return true;
                }
            }
            return false;
        });
        this.setState({data: searchdata});
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
                            placeholder="検索..."
                            onChange={this._search.bind(this)}
                            onFocus={this._startSearching.bind(this)}
                            onBlur={this._doneSearching.bind(this)} />
                    </div>
                </div>
                <div className={styles.WhinepadDatagrid}>
                    <Excel
                        schema={this.props.schema}
                        initialData={this.state.data}
                        onDataChange={this._onExcelDataChange.bind(this)} />
                </div>
                {this.state.addnew
                    ? <Dialog
                        modal={true}
                        header="項目の追加"
                        confirmLabel="追加"
                        onAction={this._addNew.bind(this)}
                    >
                        <Form
                            ref="form"
                            fields={this.props.schema} />
                    </Dialog>
                    : null}
            </div>
        );
    }
}

export default Whinepad;