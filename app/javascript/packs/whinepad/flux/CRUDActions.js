/ *flow */

import CRUDStore from './CRUDStore';

const CRUDActions = {
    create(newRecord: Object) {
        let data = CRUDStore.getData();
        data.unshift(newRecord);
        CRUDStore.setData(data);
    },

    delete(recordId: number) {
        let data = CRUDStore.getData();
        data.splice(recordId, 1);
        CRUDStore.setData(data);
    },

    updateRecord(recordId: number, newRecord: Object) {
        let data = CRUDStore.getData();
        data[recordId] = newRecord;
        CRUDStore.setData(data);
    },

    updateField(recordId: number, key: string, value: string|number) {
        let data = CRUDStore.getData();
        data[recordId][key] = value;
        CRUDStore.setData(data);
    },

    _preSeacheData: null,

    startSearching() {
        this._preSeacheData = CRUDStore.getData();
    },

    search(e: Event) {
        const target = ((e.target: any): HTMLElement);
        const needle: string = target.value.toLocaleLowerCase();
        if(!needle) {
            CRUDStore.setData(this._preSeacheData);
            return;
        }
        const fields = CRUDStore.getSchema().map(item => item.id);
        if (!this._preSeacheData) {
            return;
        }
        const searchdata = this._preSeacheData.filter(row => {
            for(let f = 0; f < fields.length; f++) {
                if (row[fields[f]].toString().toLowerCase().indexOf(needle) > -1) {
                    return true;
                }
            }
            return false;
        });
        CRUDStore.setData(searchdata, /* commit */ false);
    },

    _sortCallback(a: (string|number), b: (string|number), descending: boolean): number {
        let res: number = 0;
        if (typeof a === 'number' && typeof b === 'number') {
            res = a - b;
        } else {
            res = String(a).localeCompare(String(b));
        }
        return descending ? -1 * res : res;
    },

    sort(key: string, descending: boolean) {
        CRUDStore.setData(CRUDStore.getData().sort(
            (a, b) => this._sortCallback(a[key], b[key], descending)
        ));
    },

};

export default CRUDActions