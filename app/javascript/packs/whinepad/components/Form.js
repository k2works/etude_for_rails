/* @flow */

import styles from '../css/components/Form.scss';
import FormInput from './FormInput';
import Rating from './Rating';
import React, {Component} from 'react';

import type {FormInputField, FormInputFieldValue} from './FormInput';

type Props = {
    fields: Array<FormInputField>,
    initialData?: Object,
    readonly?: boolean,
};


class Form extends Component {

    props: Props;

    getData(): Object {
        let data: Object = {};
        this.props.fields.forEach(field =>
        data[field.id] = this.refs[field.id].getValue()
        );
        return data;
    }
    render() {
        return (
            <form className={styles.Form}>{this.props.fields.map(field => {
                const prefilled: FormInputFieldValue = (this.props.initialData && this.props.initialData[field.id]) || '';
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