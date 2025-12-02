import {Injectable} from '@angular/core';
import {IService} from '../IService';
import {KBE} from '../../models/kbe.model';

@Injectable({
  providedIn: 'root',
})
export class KBEService implements IService<KBE> {


  _template: KBE = {
    id: 1, text: "<h1>asdasdasdasd</h1>", createdAt: new Date(), updatedAt: new Date(),
  }

  list(): Promise<KBE[]> {
    throw new Error("Method not implemented.");
  }

  getById(id: number): Promise<KBE[]> {
    throw new Error("Method not implemented.");
  }

  get(): Promise<KBE> {
    return Promise.resolve(this._template);
  }

  create(item: KBE): Promise<KBE> {
    throw new Error("Method not implemented.");
  }

  delete(id: number): Promise<KBE> {
    throw new Error("Method not implemented.");
  }

  update(item: KBE): Promise<KBE> {
    this._template = item;
    return Promise.resolve(this._template);
  }

}
