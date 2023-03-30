import { ApiProperty } from '@nestjs/swagger';

class AssignRequestResult {
  id: number;
  message?: string;
}

export class MultipleVolunteerAssignEntity {
  @ApiProperty({
    isArray: true,
    description:
      'Contains valid request results, its items have two properties: id and message. ID is the id of the valid object, message is optional',
  })
  validRequests: AssignRequestResult[];

  @ApiProperty({
    isArray: true,
    description:
      'Contains invalid request results, its items have two properties: id and message. ID is the id of the invalid object, message is optional',
  })
  invalidRequests: AssignRequestResult[];
}
