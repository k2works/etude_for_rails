/* @flow */
'use strict';

import styles from './css/app.scss';
import Logo from './components/Logo';
import React from 'react';
import ReactDOM from 'react-dom';
import Whinepad from './components/Whinepad';
import schema from './schema';

let data: Array<Object>;
const storage: ?string = localStorage.getItem('data');

// サンプルデータをスキーマから読み込みます
if(!storage) {
    data = [{}];
    schema.forEach(item => data[0][item.id] = item.sample);
} else {
    data = JSON.parse(storage);
}

ReactDOM.render(
    <div>
        <div className={styles.app__header}>
            <Logo/> Whinepadにようこそ!
        </div>
        <Whinepad schema={schema} initialData={data} />
    </div>,
    document.getElementById('pad')
);