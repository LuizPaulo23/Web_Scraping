import requests
from bs4 import BeautifulSoup

# URL do site
url = 'http://www.slavevoyages.org/estimates/p1kSLxG3'

# Fazendo a requisição GET para obter o conteúdo da página
response = requests.get(url)

# Verifica se a requisição foi bem-sucedida
if response.status_code == 200:
    # Criando o objeto BeautifulSoup
    soup = BeautifulSoup(response.content, 'html.parser')

    # Encontrando a tabela pelo seletor CSS
    table = soup.select_one('table')

    # Verificando se a tabela foi encontrada
    if table:
        # Percorrendo as linhas da tabela
        for row in table.find_all('tr'):
            # Obtendo as colunas da linha
            columns = row.find_all('td')
            
            # Imprimindo os valores das colunas
            for column in columns:
                print(column.text.strip())
            
            # Imprimindo uma linha em branco para separar as linhas da tabela
            print()
    else:
        print('Nenhuma tabela encontrada na página.')
else:
    print('Falha ao obter o conteúdo da página:', response.status_code)

