/* @flow */

import Actions from './Actions';
import Dialog from './Dialog';
import Form from './Form';
import FormInput from './FormInput';
import Rating from './Rating';
import React, {Component,PropTypes} from 'react';
import styles from '../css/components/Excel.scss';
import scheam from '../css/schema.scss';
import invariant from 'invariant';

type Data = Array<Object>;

type Props = {
    schema: Array<Object>,
    initialData: Data,
    onDataChange: Function,
};

type EditState = {
    row: number,
    key: string,
};

type DialogState = {
    idx: number,
    type: string,
};

type State = {
    data: Data,
    sortby: ?string,
    descending: boolean,
    edit: ?EditState,
    dialog: ?DialogState,
};

class Excel extends Component {

    props: Props;
    state: State;

    constructor(props: Props) {
        super(props);
        this.state = {
            data: this.props.initialData,
            sortby: null, // schema.id
            descending: false,
            edit: null, // {row: 行番号, cell: 列番号}
            dialog: null, // {type: 種類, idx: 行番号}
        };
    }

    componentWillReceiveProps(nextProps: Props) {
        this.setState({data: nextProps.initialData});
    }

    _fireDataChange(data: Data) {
        this.props.onDataChange(data);
    }

    _sort(key: string) {
        let data = Array.from(this.state.data);
        const descending = this.state.sortby === key && !this.state.descending;
        data.sort(function (a,b) {
            return descending
                ? (a[key] < b[key] ? 1 : -1)
                : (a[key] > b[key] ? 1 : -1);
        });
        this.setState({
            data: data,
            sortby: key,
            descending: descending,
        });
        this._fireDataChange(data);
    }

    _showEditor(e: Event) {
        const target = ((e.target: any): HTMLElement);
        this.setState({edit: {
            row: parseInt(target.dataset.row, 10),
            key: target.dataset.key,
        }});
    }

    _save(e: Event) {
        e.preventDefault();
        const value = this.refs.input.getValue();
        let data = Array.from(this.state.data);
        invariant(this.state.edit, 'ステートeditが不正です');
        data[this.state.edit.row][this.state.edit.key] = value;
        this.setState({
            edit: null,
            data: data,
        });
        this._fireDataChange(data);
    }

    _actionClick(rowidx: number, action: string) {
        this.setState({dialog: {type: action, idx: rowidx}});
    }

    _deleteConfirmationClick(action: string) {
        if (action === 'dismiss') {
            this._closeDialog();
            return;
        }
        const index = this.state.dialog ? this.state.dialog.idx : null;
        invariant(typeof index === 'number', '予期せぬステータスです');
        let data = Array.from(this.state.data);
        data.splice(index, 1);
        this.setState({
            dialog: null,
            data: data,
        });
        this._fireDataChange(data);
    }

    _closeDialog() {
        this.setState({dialog: null});
    }

    _saveDataDialog(action: string) {
        if (action === 'dismiss') {
            this._closeDialog();
            return;
        }
        let data = Array.from(this.state.data);
        const index = this.state.dialog ? this.state.dialog.idx : null;
        invariant(typeof index === 'number', '予期せぬステータスです');
        data[index] = this.refs.form.getData();
        this.setState({
            dialog: null,
            data: data,
        });
        this._fireDataChange(data);
    }

    _selectCssClass(isRating: boolean,schema: Object) {
        if(isRating) {
            return styles.Excel__td;
        }

        if(!isRating) {
            return styles.ExcelEditable
        } else if (schema.align === 'left') {
            return styles.ExcelDataRight
        } else if (schema.align === 'right') {
            return styles.ExcelDataRight
        } else if (schema.align === 'left' && schema.align !== 'right') {
            return styles.ExcelDataCenter
        } else {
            return this._selectSchemaCss(schema.id);
        }
    }

    _selectSchemaCss(id: string) {
        switch (id) {
            case 'name':
                return scheam.schema_name;
            case 'year':
                return scheam.schema_year;
            case 'grape':
                return scheam.schema_grape;
            case 'rating':
                return scheam.schema_rating;
            default:
                throw Error(`該当するCSSがありません: ${id}`);
        }
    }

    render() {
        return (
            <div className={styles.Excel}>
                {this._renderTable()}
                {this._renderDialog()}
            </div>
        );
    }

    _renderDialog() {
        if (!this.state.dialog) {
            return null;
        }
        switch (this.state.dialog.type) {
            case 'delete':
                return this._renderDeleteDialog();
            case 'info':
                return this._renderFormDialog(true);
            case 'edit':
                return this._renderFormDialog();
            default:
                throw Error(`不正なダイアログの種類:  ${this.state.dialog.type}` );
        }
    }

    _renderDeleteDialog() {
        const index = this.state.dialog ? this.state.dialog.idx : null;
        invariant(typeof index === 'number', '予期せぬステータスです');
        const first = this.state.data[index];
        const nameguess = first[Object.keys(first)[0]];
        return (
            <Dialog
                modal={true}
                header="削除の確認"
                confirmLabel="削除"
                onAction={this._deleteConfirmationClick.bind(this)}
                >
                {`削除してもよいですか: "${nameguess}"?`}
            </Dialog>
        );
    }

    _renderFormDialog(readonly: ?boolean) {
        const index = this.state.dialog ? this.state.dialog.idx : null;
        invariant(typeof index === 'number', '予期せぬステータスです');
        return (
            <Dialog
                modal={true}
                header={readonly ? '項目の情報' : '項目の編集'}
                confirmLabel={readonly ? 'OK' : '保存'}
                hasCancel={!readonly}
                onAction={this._saveDataDialog.bind(this)}
            >

                <Form
                    ref="form"
                    fields={this.props.schema}
                    initialData={this.state.data[index]}
                    readonly={readonly} />
            </Dialog>
        );
    }

    _renderTable() {
        return (
            <table className={styles.Excel__table}>
                <thead>
                <tr>{
                    this.props.schema.map(item => {
                        if(!item.show) {
                            return null;
                        }
                        let title = item.label;
                        if(this.state.sortby === item.id) {
                            title += this.state.descending ? ' \u2191' : ' \u2193';
                        }
                        return (
                            <th
                                className={this._selectSchemaCss(item.id)}
                                key={item.id}
                                onClick={this._sort.bind(this, item.id)}
                            >
                                {title}
                            </th>
                        );
                    }, this)
                }
                    <th className={styles.ExcelNotSortable}>操作</th>
                </tr>
                </thead>
                <tbody onDoubleClick={this._showEditor.bind(this)}>
                {this.state.data.map((row, rowidx) => {
                    return (
                        <tr key={rowidx}>{
                            Object.keys(row).map((cell, idx) => {
                                const schema = this.props.schema[idx];
                                if(!schema || !schema.show) {
                                    return null;
                                }
                                const isRating = schema.type === 'rating';
                                const edit = this.state.edit;
                                let content = row[cell];
                                if(!isRating && edit
                                    && edit.row === rowidx && edit.key === schema.id) {
                                    content = (
                                        <form onSubmit={this._save.bind(this)}>
                                            <FormInput ref="input" {...schema}
                                            defaultValue={content}/>
                                        </form>
                                    );
                                } else if (isRating) {
                                    content = <Rating readonly={true}
                                    defaultValue={Number(content)} />;
                                }
                                return (
                                    <td
                                        className={
                                            this._selectCssClass(isRating,schema)
                                        }
                                        key={idx}
                                        data-row={rowidx}
                                        data-key={schema.id}>
                                        {content}
                                    </td>
                                );
                            },this)}
                            <td className={styles.ExcelDataCenter}>
                                <Actions onAction={this._actionClick.bind(this, rowidx)} />
                            </td>
                        </tr>
                    );
                }, this)}
                </tbody>
            </table>
        );
    }
}

Excel.propTypes = {
    schema: PropTypes.arrayOf(
        PropTypes.object
    ),
    initialData: PropTypes.arrayOf(
        PropTypes.object
    ),
    onDataChange: PropTypes.func,
};

export default Excel