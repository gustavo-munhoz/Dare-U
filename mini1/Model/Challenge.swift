//
//  Goal.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 21/06/23.
//

import Foundation

struct Challenge: Codable, Identifiable, Equatable {
    var id: UUID
    var description: String
    var isComplete: Bool
    var category: String
    var timesCompletedThisWeek: Int
    var dateOfCreation: Date
    var lastCompletionDate: Date?
    var imageName: String
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case category = "category"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.description = try container.decode(String.self, forKey: .description)
        self.isComplete = false
        self.category = try container.decode(String.self, forKey: .category)
        self.timesCompletedThisWeek = 0
        self.dateOfCreation = Date()
        self.lastCompletionDate = nil
        self.imageName = "\(self.category.lowercased())\(Int.random(in: 1...3))"
    }
    
    init(id: UUID = UUID(), description: String, isComplete: Bool = false, category: String) {
        self.id = id
        self.description = description
        self.isComplete = isComplete
        self.category = category
        self.timesCompletedThisWeek = 0
        self.dateOfCreation = Date()
        self.lastCompletionDate = nil
        self.imageName = "\(self.category.lowercased())\(Int.random(in: 1...3))"
    }
    
    static func fetchChallenges(previousChallenges: [Challenge] = [], completion: @escaping ([Challenge]) -> Void) {
        let apiKey = Secrets.CHATGPT_API_KEY
        let model = "gpt-3.5-turbo"
        
        var prompt = """
        Sua função é criar desafios criativos, simples e divertidos que duas pessoas possam realizar juntas diariamente. Importante, eles PRECISAM SER FEITOS TODOS OS DIAS, por isso pense em algo que seja factível todos os dias da semana e que não exceda 30 minutos por dia. Cada desafio será composto por uma descrição (chave JSON: 'description') e uma categoria (chave JSON: 'category'). As categorias possíveis são: autocuidado, esporte, habilidade, culinária, mente, tecnologia ou arte. Não crie nenhuma outra categoria.
        Os desafios devem ser concisos, fáceis de entender e algo que possa ser realizado em um dia. Cada desafio deve ser diferente um do outro para garantir variedade.
        Exemplos de desafios que queremos:
        - Desafio 1:
          Description: 'Andar 2km de skate'
          Category: 'esporte'
        - Desafio 2:
          Description: 'Tomar 1L de água'
          Category: 'autocuidado'
        - Desafio 3:
          Description: 'Hidratar o rosto com creme'
          Category: 'autocuidado'
        - Desafio 4:
          Description: 'Tomar café da manhã'
          Category: 'culinária'
        Exemplos de desafios que não queremos:
        - Desafio:
          Description: 'Aprender uma nova receita'
          Category: 'culinária' (Razão: Não é factível aprender uma nova receita todos os dias.)
        - Desafio:
          Description: 'Correr uma maratona'
          Category: 'esporte' (Razão: Correr uma maratona todos os dias é muito extenuante e demorado.)
        """

        for challenge in previousChallenges {
            prompt += "\n- Desafio:\n  Description: '\(challenge.description)'\n  Category: '\(challenge.category)' (Razão: Este desafio já foi criado anteriormente.)"
        }

        prompt += """
        Agora, por favor, gere quatro desafios seguindo o formato dos exemplos que queremos. Formate a resposta como uma matriz de objetos JSON, onde cada objeto representa um desafio. Mande somente 4 desafios, sem nenhum texto extra. NÃO gere textos no começo como 'aqui está sua matriz...' ou textos no final, mande somente a matriz. Lembre-se, para a descrição use a chave 'description' e para a categoria use a chave 'category'. Para 'category', sempre coloque textos lowercased e sem acentos.
        """
        
        let promptSys = Prompt(role: "system", content: prompt)
        
        let reqJson = Request(model: model, messages: [promptSys])
        let encoder = JSONEncoder()
        let jsonData = try? encoder.encode(reqJson)
        
        var req = URLRequest(url: URL(string: "https://api.openai.com/v1/chat/completions")!)
            req.httpMethod = "POST"
            req.addValue("application/json", forHTTPHeaderField: "Content-Type")
            req.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            req.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: req) { data, res, error in
            if let error = error {
                print("Erro na requisição: \(error)")
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    print(jsonObject)
                    
                    let res = try decoder.decode(ChatGptResponse.self, from: data)
                    let jsonText = res.choices[0].message.content

                    // Transforma a resposta da API em um array de Challenge
                    let challenges = createChallenges(from: jsonText)
                    completion(challenges)
                } catch {
                    print("Erro na decodificação: \(error)")
                }
            }
        }
        task.resume()
    }
    
    static func createChallenges(from jsonResponse: String) -> [Challenge] {
        // Converter a string de resposta JSON em dados
        guard let jsonData = jsonResponse.data(using: .utf8) else {
            print("Falha ao converter string de resposta JSON em dados.")
            return []
        }

        // Decodificar os dados em um array de objetos Challenge
        do {
            let challenges = try JSONDecoder().decode([Challenge].self, from: jsonData)
            return challenges
        } catch {
            print("Falha ao decodificar dados JSON em objetos Challenge: \(error)")
            return []
        }
    }
}
