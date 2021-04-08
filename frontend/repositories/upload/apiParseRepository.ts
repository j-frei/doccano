import ApiService from '@/services/api.service'
import { ParseRepository } from '@/domain/models/upload/parseRepository'

export class APIParseRepository implements ParseRepository {
  constructor(
    private readonly request = ApiService
  ) {}

  async analyze(projectId: string, format: string, uploadIds: number[]): Promise<string> {
    const url = `/projects/${projectId}/upload`
    const data = {
      format,
      uploadIds
    }
    const response = await this.request.post(url, data)
    return response.data.task_id
  }
}