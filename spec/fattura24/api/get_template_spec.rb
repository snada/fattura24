# frozen_string_literal: true

RSpec.describe Fattura24::Api do
  describe '#get_template' do
    let(:url) { 'https://www.app.fattura24.com/api/v0.3/GetTemplate' }

    context 'with an invalid api key' do
      include_context 'invalid api key'

      it 'returns error' do
        expect(Fattura24::Api.get_template.to_h).to eq(invalid_api_key_response)
      end
    end

    context 'with a valid api key' do
      let(:xml) { File.read('spec/fixtures/templates.xml') }

      before(:each) do
        Fattura24.configure do |c|
          c.api_key = 'valid'
        end

        stub_request(:post, url)
          .with(body: { apiKey: 'valid' })
          .to_return(status: 200, body: xml, headers: {})
      end

      it 'returns a valid response' do
        expect(Fattura24::Api.get_template.to_h).to eq(
          root: {
            hostname: 'f24nodo3',
            modello_ddt: {
              data_creazione: '27/08/2019',
              descrizione: "\n      Documento di trasporto - Alternativo\n    ",
              id: '8098',
              id_tipo_documento: '8',
              id_utente: '0',
              is_default: 'false',
              is_work_city: '1',
              nota: "\n      \n    ",
              owner: 'Modelli Fattura24'
            },
            modello_fattura: {
              data_creazione: '27/08/2019',
              descrizione: "\n      Modello \"Agenti di commercio\"\n    ",
              id: '65',
              id_tipo_documento: '1',
              id_utente: '0',
              is_default: 'false',
              is_work_city: '1',
              nota: "\n      Questo modello, e' stato pensato per gli Agenti di Commercio.\n\n\n\nE' caratterizzato dalla presenza della ritenuta Enasarco.\n    ",
              owner: 'Modelli Fattura24'
            },
            modello_fattura_fe: {
              data_creazione: '27/08/2019',
              descrizione: "\n      Modello \"Agenti di commercio\"\n    ",
              id: '65',
              id_tipo_documento: '1',
              id_utente: '0',
              is_default: 'false',
              is_work_city: '1',
              nota: "\n      Questo modello, e' stato pensato per gli Agenti di Commercio.\n\n\n\nE' caratterizzato dalla presenza della ritenuta Enasarco.\n    ",
              owner: 'Modelli Fattura24'
            },
            modello_ordine: {
              data_creazione: '05/03/2020',
              descrizione: "\n      Ordine - SmartCod\n    ",
              id: '31267',
              id_tipo_documento: '12',
              id_utente: '0',
              is_default: 'false',
              is_work_city: '1',
              nota: "\n      \n    ",
              owner: 'Modelli Fattura24'
            },
            modello_preventivo: {
              data_creazione: '05/03/2020',
              descrizione: "\n      Preventivi - SmartCod\n    ",
              id: '31270',
              id_tipo_documento: '6',
              id_utente: '0',
              is_default: 'false',
              is_work_city: '1',
              nota: "\n      \n    ",
              owner: 'Modelli Fattura24'
            },
            modello_rapportino: {
              data_creazione: '27/08/2019',
              descrizione: "\n      Rapportino Elegante\n    ",
              id: '9538',
              id_tipo_documento: '17',
              id_utente: '0',
              is_default: 'true',
              is_work_city: '1',
              nota: "\n      \n    ",
              owner: 'Modelli Fattura24'
            },
            return_cod: 'TP04',
            return_mes: 'OK'
          }
        )
      end
    end
  end
end
