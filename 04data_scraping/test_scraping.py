from selenium import webdriver
from selenium.webdriver.common.by import By 
driver = webdriver.Chrome()
driver.get("https://search.shopping.naver.com/book/home")
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time

options = Options()
options.add_experimental_option("detach", True)
options.add_argument("start-maximized")
options.add_argument("Chrome/135.0.0.0")
options.add_argument("lnag=ko_KR")


driver = webdriver.Chrome(
    service=Service(ChromeDriverManager().install()),
    options=options
    )
driver.get("https://search.shopping.naver.com/book/search?bookTabType=ALL&pageIndex=1&pageSize=40&prevQuery=%EB%84%A4%EC%9D%B4%EB%B2%84%20%EC%B1%85&query=%ED%8C%8C%EC%9D%B4%EC%8D%AC&sort=REL")







search_box = driver.find_element(By.CSS_SELECTOR, "._searchInput_search_input_4SbSW ._searchInput_search_text_83jy9")
search_box.clear()
search_box.send_keys("파이썬")
search_box.send_keys(Keys.ENTER)
for page_num in range(1, 6):
    print(f"{page_num}페이지 수집중", end="\r")

    for _ in range(5):
        driver.execute_script("window.scrollBy(0, 1000)")
        time.sleep(3)


    # 책 항목 추출
    book_items = driver.find_elements(By.CSS_SELECTOR, "#book_list > ul > li")

    # 결과 저장 리스트
    books_data = []

    # 책 정보 수집
    for item in book_items:
        try:
            title = item.find_element(By.CLASS_NAME, "bookListItem_title__1mWGq").text
        except:
            title = ""

        try:
            link = item.find_element(By.CSS_SELECTOR, "a.linkAnchor").get_attribute("href")
        except:
            link = ""

        try:
            image = item.find_element(By.CSS_SELECTOR, "img").get_attribute("src")
        except:
            image = ""

        try:
            author = item.find_element(By.CSS_SELECTOR, "div.bookListItem_detail__VW1kD > div:nth-child(1) > span.bookListItem_define_data__fu2A5").text
        except:
            author = ""

        try:
            publisher = item.find_element(By.CSS_SELECTOR, "div.bookListItem_detail_publish__SGgZN > span.bookListItem_define_data__fu2A5").text
        except:
            publisher = ""

        try:
            pub_date = item.find_element(By.CLASS_NAME, "bookListItem_detail_date__6_wYJ").text
        except:
            pub_date = ""

        try:
            rating = item.find_element(By.CLASS_NAME, "bookListItem_grade__e60mi").text
        except:
            rating = ""

        try:
            price = item.find_element(By.CSS_SELECTOR, "div > div > div:nth-child(1)").text
        except:
            price = ""
            time.sleep(2)

        books_data.append({
            "제목": title,
            "링크": link,
            "이미지": image,
            "저자": author,
            "출판사": publisher,
            "출간일": pub_date,
            "평점": rating,
            "가격": price
        })
    if page_num < 5:
        try:
            # 페이지 바 안에 있는 페이지 번호 링크들 찾기
            pagination_area = driver.find_element(By.CLASS_NAME, "Paginator_list_paging__XbuO8")
            page_links = pagination_area.find_elements(By.CSS_SELECTOR, "a.linkAnchor._nlog_click._nlog_impression_element")

            # 클릭할 버튼 찾기 (텍스트로 정확히 일치)
            for btn in page_links:
                if btn.text.strip() == str(page_num + 1):
                    btn.click()
                    time.sleep(3)  # 다음 페이지 로딩 대기
                    break

        except Exception as e:
            print("페이지 이동 중 오류:", e)
            break

    
df = pd.DataFrame(books_data)
df