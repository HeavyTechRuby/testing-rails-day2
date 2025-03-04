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

## TDD Demo

---

## Философия

* маленькие шаги
* постоянный Рефакторинг
* эволюционный дизайн
* исполняемая документация
* минимальность кода

---

## Ошибки TDD

* написание теста в конце
* Выбор большого шага

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
    it "is not valid without title
    it "is not valid without author
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

## eq / be / be_truthey

---

## match / start_with / end_with / include

---

## вложенные блоки 

hash_including / array_include /...

---

# raise

---

## change

---

## custome matcher


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

# mocks / stubs

---


## Тестирование Requsts

* тестирование всей структуры
* ожидание только важного
* авторизация

---

## Ошибки тестирования Requests

* тестирование валидации
* тестирование i18n
* тестирование Model


---

## Принципы хорошего теста

* чистый код
* тест как история
* Arracnge Act Assert
* быстрый
* независимый
* повторяемый
* скрытые нерелевантные детали
* одна проверка

---


## Link 

* https://tddmanifesto.com/
