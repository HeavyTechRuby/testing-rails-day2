---
marp: true
---

# Тестирование Ruby on Rails приложений

День 2

---

## День 1

* Почему нужны автотесты
* Почему разработчики избегают тесты
* Основы RSpec
* Тестирование Model
* Factory Bot

---

## День 2

* TDD
* BDD
* Синтаксис RSpec
* Тестирование Requests
* Приниципы хорошего тесты
* Рефакторинг тестов

---

## TDD

* Красный: написать падающий тест
* Зеленый: написать минимальный код для прохождения теста
* Рефакторинг: улучшить код, сохраняя зеленый


---

## Red

```Ruby
RSpec.describe Episode do
  subject(:episode) { described_class.new(duration:) }

  describe "#duration_in_minutes" do
    subject { episode.duration_in_minutes }

    context do
      let(:duration) { 60 }
      it { is_expected.to eq 1 }
    end
  end
end
```

---

## Green

```Ruby
class Episode
  def inialise(duration:)
    @duration = duration
  end

  def duration_in_minutes = 1
end
```

---

## Refactoring

```Ruby
class Episode
  def inialise(duration:)
    @duration = duration
  end

  def duration_in_minutes = @duration  / 60
end
```

---

## Философия

* маленькие шаги
* постоянный рефакторинг
* эволюционный дизайн
* исполняемая документация
* минимальность кода

---

## Ошибки TDD

* написание теста в конце
* выбор большого шага

---

## BDD

* Тесты должны объяснять, что делает система, а не как она это делает
* Тесты читаются как сценарии из реального мира
* Разработчики, тестировщики и бизнес говорят на одном языке

---

## Cucumber

```gherkin
Feature: Episode listening
  As listener 
  I want to pause episode
  To continue later

  Scenario: Pause in a middle of episode
    Given I have episode palying
    When I pause episode at 20 mitute
    Then episode saves current position
```

---

## RSpec

```ruby
describe "Episode listening" do
  let(:listener) { Listener.new }
  let(:episode) { Episode.new(duration: 1.hour) }

  it "pauses in a middle of episode" do
    # Given
    episode.start_playback(listener)

    # When
    episode.pause_playback(listener, at: 20.minute)

    # Then
    expect(episode.last_pause_position(listener)).to eq(20.minute)
  end
end
```

---

## Ошибки BDD

---

## Тесты не читаются

```ruby
RSpec.describe Episode do
  # Bad
  it "episode pause in a middle"

  # Good
  it "pauses in a middle of episode" do
end
```

---

## Тестирование реализации а не поведения

```ruby
it "pauses in a middle of episode" do
  # Bad
  expect(episode).to receive(:cache_playback).with(20.minutes)

  episode.start_playback(listener)
  episode.pause_playback(listener, at: 20.minutes)
  expect(episode.last_pause_position(listener)).to eq(20.minutes)
end
```

---

## Большое увлечение синтаксисом и DSL

---

## Синтаксис RSpec

---

## describe

```ruby
describe "Episode duration" do
  subject { episode.duration }
end
```

---

## subject

```ruby
describe "Episode duration" do
  subject { episode.duration }

  it { expect(subject).to eq 10 }
  it { is_expected.to eq 10 }
end
```

---

## subject nested

```ruby
describe Episode do
  subject(:episode) { descibed_class.new }
  it { is_expected.to be_new }

  describe "#duration" do
    subject { episode.duration }

    it { expect(subject).to eq 10 }
    it { is_expected.to eq 10 }
  end
```

---

## context

```ruby
describe "Episode duration" do
  subject { episode.duration }

  context "when episode has no content" do
    before { episode.content = nil }
    it { is_expected.to eq 0 }
  end

  context "when validation errors" do
    it "is not valid without title"
    it "is not valid without author"
  end
end
```

---

## let

```ruby
let(:episode) { create(:episode) }
let(:user) { create(:user) } # not created

it { expect(episode).to be_an(Episode) }
```

---

## let!


```ruby
describe "found items" do
  subject { Episode.recent }

  context do
    let(:episode) { create(:episode) }
    before { episode } # create episode

    it { expect(subject.size).to eq 1 }
  end

  context do
    let!(:episode) { create(:episode) }

    it { expect(subject.size).to eq 1 }
  end
end

```

---

## Matchers

---

## eq


```ruby
expect(1).to eq(1)
expect(1).to eql(1)
expect(1).to equal(1)
```

---

## be_a

```ruby
expect(1).to be_a(Number)
expect(1).to be_an(Integer)
expect(1).to be_a_kind_of(Number)
```

---

## be_*

```ruby
expect(found_item).to be_nil # found_item.nil?
expect(episode).to be_published # episode.published?
```

---

## match / start_with / end_with

```ruby
expect("Long Title).to match(/Title.+/)
expect("Long Title").to match("Long")
expect("Title with dot.").to end_with(".")
expect("Title Here").to start_with("Title")
```

---

## raise

```ruby
expect { do_something_risky }.to raise_error
expect { do_something_risky }.to raise_error(PoorRiskDecisionError)
```

---

## change

```ruby
expect { podcast.add_episode(episode) }.to change(podcast, :size).from(0).to(1)
expect { podcast.add_episode(episode) }.to change(podcast, :size).to(1)
expect { podcast.remove_episode(episode) }.to change(podcast, :size).by(-1)
expect { podcast.add_episode(episode) }.to change{ podcast.reload.size }.by(1)
```

---

## custom matcher


```ruby
RSpec::Matchers.define :be_published do
  match do |episode|
    episode.published? && episode.publication_date <= Time.current
  end
end

it "publishes episode" do
  episode.publish!
  expect(episode).to be_published
end
```

---

## alias_matcher

```ruby
RSpec::Matchers.alias_matcher :be_empty, :be_nil

expect(search_results).to be_empty
```

---

## match partial

```ruby
hash = {
  a: {
    b: ["foo", 5],
    c: { d: 2.05 }
  }
}
expect(hash).to match(
  a: {
    b: a_collection_containing_exactly(
      a_string_starting_with("f"),
      an_instance_of(Fixnum)
    ),
    c: { d: (a_value < 3) }
  }
)
```

---

## Тестирование Requsts

---

## Первый запрос

```ruby
describe "GET /index" do
  it "works" do
    get podcasts_url
  end
end
```

---



```ruby
describe "GET /index" do
  it "renders a successful response" do
    get podcasts_url
    expect(response).to be_successful
  end
end
```

---

## Практика

* request
* response
    * header
    * body
    * status
* side effect
* авторизация

---

## Ошибки тестирования Requests

* ожидание только важного
* тестирование валидации
* тестирование i18n
* тестирование Model


---

## Принципы хорошего теста

* чистый код
* тест как история
* Arrange Act Assert
* быстрый
* независимый
* повторяемый
* скрытые нерелевантные детали
* одна проверка

---

## Рефакторинг

---

## shared_exmple


```ruby
RSpec.shared_examples 'engine startable' do
  it 'starts engine' do
    expect(subject.start_engine).to eq(true)
  end
end

it_behaves_like 'engine startable'
include_examples 'engine startable'
```

---

## share-context

```ruby
RSpec.shared_context 'order setup' do
  let(:item1) { double('Item', price: 10) }
  let(:item2) { double('Item', price: 20) }
  let(:order) { Order.new([item1, item2]) }
end
include_context 'order setup'
```

---

## matcher

```ruby
RSpec::Matchers.define :include_item do |id|
  match do |subject|
    subject.map(&:id).to include(id)
  end
end

it { is_expected.to inlucde_item(podcast.id) }
```

---

## def


---

## Link 

* [TDD Manifesto](https://tddmanifesto.com/)
* [RSpec matchers](https://rspec.info/documentation/3.0/rspec-expectations/RSpec/Matchers)
* [Rails Function Tests](https://guides.rubyonrails.org/testing.html#functional-testing-for-controllers)
* [Rspec Mocks](https://rspec.info/documentation/3.13/rspec-mocks/)
