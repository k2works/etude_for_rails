import React from 'react';
import { spy } from 'sinon';
import { expect } from 'chai';
import assert from 'power-assert';
import { shallow, mount } from 'enzyme';
import { Square, Board, Game } from '../../app/javascript/packs/intro_to_reacts/components';

describe('IntroToReacts', () => {
    describe('Square', () => {
        it('should render button', () => {
            const wrapper = shallow(<Square/>);
            expect(wrapper.find('button')).to.have.length(1);
        });
    });

    describe('Board', () => {
        it('should render square', () => {
            const wrapper = shallow(<Board/>);
            expect(wrapper.containsAllMatchingElements([
                <Square/>,
            ])).to.equal(true);
        });
        it('should start with null value', () =>{
            const wrapper = shallow(<Board/>);
            let exp = Array(9).fill(null);
            expect(wrapper.state('squares')).to.eql(exp);
        });
        it('adds squares when clicked', () => {
            const wrapper = shallow(<Board/>);
            wrapper.instance().handleClick(0);
            expect(wrapper.state('squares')[0]).to.eql('X');
        });
        it('toggle x is next when clicked', () => {
            const wrapper = shallow(<Board/>);
            wrapper.instance().handleClick(0);
            expect(wrapper.state('xIsNext')).to.eql(false);
            wrapper.instance().handleClick(1);
            expect(wrapper.state('xIsNext')).to.eql(true);
        });
        it('declaring a winner', () => {
            const wrapper = shallow(<Board/>);
            wrapper.instance().handleClick(0);
            wrapper.instance().handleClick(9);
            wrapper.instance().handleClick(1);
            wrapper.instance().handleClick(8);
            wrapper.instance().handleClick(2);
            expect(wrapper.find('.status').text()).to.be.eql('Winner: X')
        })
    });

    describe('Game', () => {
        it('should render board', () => {
            const wrapper = shallow(<Game/>);
            expect(wrapper.containsAllMatchingElements([
                <Board/>,
            ])).to.equal(true);
        });
    });
});