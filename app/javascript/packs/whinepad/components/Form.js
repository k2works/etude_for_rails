import styles from '../css/components/Form.scss';
import FormInput from './FormInput';
import Rating from './Rating';
import React, {Component, PropTypes} from 'react';

class Form extends Component {
    getData() {
        let data = {};
        this.props.fields.forEach(field =>
        data[field.id] = this.refs[field.id].getValue()
        );
        return data;
    }
    render() {
        return (
            <form className={styles.Form}>{this.props.fields.map(field => {
                const prefilled = this.props.initialData && this.props.initialData[field.id];
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

Form.propTypes = {
    fields: PropTypes.arrayOf(PropTypes.shape({
        id: PropTypes.string.isRequired,
        label: PropTypes.string.isRequired,
        type: PropTypes.string,
        options: PropTypes.arrayOf(PropTypes.string),
    })).isRequired,
    initialData: PropTypes.object,
    readonly: PropTypes.bool,
};

export default Form