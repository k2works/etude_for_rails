/* eslint-disable no-unused-vars */
/* @flow */

import styles from '../css/components/Button.scss';
import React from 'react';

type Props = {
    href: ?string,
    className: ?string,
};

const Button = (props: Props) =>
    props.href
        ? <a {...props} className={styles.Button} />
        : <button {...props} className={styles.Button} />

export default Button
