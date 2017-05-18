import React from 'react';
import { spy } from 'sinon';
import { expect } from 'chai';
import assert from 'power-assert';
import { shallow, mount } from 'enzyme';
import Excel from '../../app/javascript/packs/whinepad/components/Excel';
import Logo from '../../app/javascript/packs/whinepad/components/Logo';
import Button from '../../app/javascript/packs/whinepad/components/Button';
import Suggest from '../../app/javascript/packs/whinepad/components/Suggest';

describe('WhinePad', () => {
    it('should render log', () => {
       const wrapper = shallow(<Logo/>);
        expect(wrapper.find('div')).to.have.length(1);
    });

    it('should render table', () => {
        let headers = ['タイトル', '年', '評価', 'コメント'];
        let data = [['テスト', '2015', '3', 'あああ']];
        const wrapper = shallow(<Excel headers={headers} initialData={data}/>);
        expect(wrapper.find('table')).to.have.length(1);
    });

    it('should render button', () => {
        const wrapper = shallow(<Button/>);
        expect(wrapper.find('button')).to.have.length(1);
    });

    it('should render datalist', () => {
        let opts = ['eenie','meenie','miney','mo'];
        const wrapper = shallow(<Suggest options={opts}/>);
        expect(wrapper.find('datalist')).to.have.length(1);
    });
});