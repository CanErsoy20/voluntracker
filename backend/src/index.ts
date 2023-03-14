export { };

declare global {
  // eslint-disable-next-line @typescript-eslint/no-namespace
  namespace PrismaJson {
    // you can use classes, interfaces, types, etc.
    class ContactInfo {
      phone: string;
      address: string;
      email: string;
    }

    class StartEndDate {
      start: Date;
      end: Date;
    }

    class Location {
      lat: number;
      lon: number;
    }
  }
}
