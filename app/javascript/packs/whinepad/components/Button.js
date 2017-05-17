import styles from '../css/components/Button.scss';
import React, {PropTypes} from 'react';

function Button(props) {
    const cssclasses = styles.Button;
    return props.href
        ? <a {...props} className={cssclasses}/>
        : <button {...props} className={cssclasses} />;

}

Button.propTypes = {
    href: PropTypes.string,
};

export default Button