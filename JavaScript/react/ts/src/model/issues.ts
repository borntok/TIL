export interface DataItem {
  login: string;
  title: string;
}

export interface Data {
  data: DataItem[];
}

export type List = Partial<DataItem> & { name: string };
