/* @flow */

import styles from '../css/components/Form.scss';
import CRUDStore from '../flux/CRUDStore';
import FormInput from './FormInput';
import Rating from './Rating';
import React, {Component} from 'react';

import type {FormInputField, FormInputFieldValue} from './FormInput';

type Props = {
    readonly?: boolean,
    recordId: ?number,
};

class Form extends Component {

    fields: Array<Object>;
    initialData: ?Object;

    constructor(props: Props) {
        super(props);
        this.fields = CRUDStore.getSchema();
        if('recordId' in this.props) {
            this.initialData = CRUDStore.getRecord(this.props.recordId)
        }
    }

    getData(): Object {
        let data: Object = {};
        this.fields.forEach((field: FormInputField) =>
            data[field.id] = this.refs[field.id].getValue()
        );
        return data;
    }
    render() {
        return (
            <form className={styles.Form}>{this.fields.map((field: FormInputField) => {
                const prefilled: FormInputFieldValue = (this.initialData && this.initialData[field.id]) || '';
                if(!this.props.readonly) {
                    return (
                        <div className={styles.FormRow} key={field.id}>
                            <labe className={styles.FormLabel} htmlFor={field.id}>{field.label}:</labe>
                            <FormInput {...field} ref={field.id} defaultValue={prefilled} />
                        </div>
                    );
                }
                if (!prefilled) {
                    return null;
                }
                return (
                    <div className={styles.FormRow} key={field.id}>
                        <span className={styles.FormLabel}>{field.label}:</span>
                        {
                            field.type === 'rating'
                                ? <Rating readonly={true} defaultValue={parseInt(prefilled, 10)} />
                                : <div>{prefilled}</div>
                        }
                    </div>
                );
            }, this)}</form>
        );
    }
}

export default Form