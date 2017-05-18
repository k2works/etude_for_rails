import React from 'react';
import { spy } from 'sinon';
import { expect } from 'chai';
import assert from 'power-assert';
import { shallow, mount } from 'enzyme';
import Excel from '../../app/javascript/packs/whinepad/components/Excel';
import Logo from '../../app/javascript/packs/whinepad/components/Logo';
import Button from '../../app/javascript/packs/whinepad/components/Button';
import Suggest from '../../app/javascript/packs/whinepad/components/Suggest';
import Rating from '../../app/javascript/packs/whinepad/components/Rating';
import FormInput from "../../app/javascript/packs/whinepad/components/FormInput";

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

    it('should render rating', () => {
        const wrapper = shallow(<Rating/>);
        expect(wrapper.find('span')).to.have.length(5);
    });

    it('should render forminput', () => {
        let wrapper = shallow(<FormInput/>);
        expect(wrapper.find('input')).to.have.length(1);

        wrapper = shallow(<FormInput defaultValue="デフォルトです" />);
        expect(wrapper.props('defaultValue').defaultValue).to.eql('デフォルトです');

        wrapper = shallow(<FormInput type="year" />);
        expect(wrapper.props('type').type).to.eql('number');

        wrapper = mount(<FormInput type="rating" defaultValue={4} />);
        expect(wrapper.props('type').type).to.eql('rating');
        expect(wrapper.find('span')).to.have.length(5);

        wrapper = mount(<FormInput
            type="suggest"
            options={['red','green','blue']}
            defaultValue="green" />);
        expect(wrapper.props('type').type).to.eql('suggest');
        expect(wrapper.find('option')).to.have.length(3);

        wrapper = mount(<FormInput type="text" />);
        expect(wrapper.props('type').type).to.eql('text');
        expect(wrapper.find('textarea')).to.have.length(1);
    });
});